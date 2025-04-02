--宝玉の氾濫
--Crystal Abundance
function c72881007.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c72881007.cost)
	e1:SetTarget(c72881007.target)
	e1:SetOperation(c72881007.activate)
	c:RegisterEffect(e1)
end
c72881007.listed_series={0x1034}
function c72881007.costfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x1034) and c:IsAbleToGraveAsCost() and c:GetSequence()<5
end
function c72881007.rescon(sg,e,tp,mg)
	return Duel.IsExistingMatchingCard(Card.IsAbleToGrave,0,LOCATION_ONFIELD,LOCATION_ONFIELD,1,sg+e:GetHandler())
end
function c72881007.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	local cg=Duel.GetMatchingGroup(c72881007.costfilter,tp,LOCATION_SZONE,0,nil)
	if chk==0 then return aux.SelectUnselectGroup(cg,e,tp,4,4,c72881007.rescon,0) end
	local g=aux.SelectUnselectGroup(cg,e,tp,4,4,c72881007.rescon,1,tp,HINTMSG_TOGRAVE)
	Duel.SendtoGrave(g,REASON_COST)
end
function c72881007.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(Card.IsAbleToGrave,0,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
	if chk==0 then
		if e:GetLabel()~=1 then
			return #g>0
		else
			e:SetLabel(0)
			return true
		end
	end
	e:SetLabel(0)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,#g,tp,0)
	Duel.SetPossibleOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c72881007.ctfilter(c,tp)
	return c:IsPreviousControler(1-tp) and c:IsLocation(LOCATION_GRAVE)
end
function c72881007.spfilter(c,e,tp)
	return c:IsSetCard(0x1034) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c72881007.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsAbleToGrave,0,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
	Duel.SendtoGrave(g,REASON_EFFECT)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local og=Duel.GetOperatedGroup()
	local ct=og:FilterCount(c72881007.ctfilter,nil,tp)
	if ct==0 then return end
	if ft>ct then ft=ct end
	if Duel.IsPlayerAffectedByEffect(tp,CARD_BLUEEYES_SPIRIT) then ft=1 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c72881007.spfilter),tp,LOCATION_GRAVE,0,ft,ft,nil,e,tp)
	if #sg>0 then
		Duel.BreakEffect()
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
	end
end