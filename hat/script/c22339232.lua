--ワイトメア
--Wightmare
function c22339232.initial_effect(c)
	--Name becomes "Skull Servant" while in the GY
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_CHANGE_CODE)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetValue(CARD_SKULL_SERVANT)
	c:RegisterEffect(e1)
	--Activate 1 of these effects
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc22339232(c22339232,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_HAND)
	e2:SetCost(c22339232.effcost)
	e2:SetTarget(c22339232.efftg)
	e2:SetOperation(c22339232.effop)
	c:RegisterEffect(e2)
end
c22339232.listed_names={CARD_SKULL_SERVANT,36021814,40991587,c22339232}
function c22339232.effcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsDiscardable() end
	Duel.SendtoGrave(c,REASON_COST|REASON_DISCARD)
end
function c22339232.spfilter(c,e,tp)
	return c:IsFaceup() and c:IsCode(36021814,40991587) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c22339232.efftg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then
		if not (chkc:IsLocation(LOCATION_REMOVED) and chkc:IsControler(tp) and chkc:IsFaceup()) then return false end
		local op=e:GetLabel()
		return (op==1 and chkc:IsCode(CARD_SKULL_SERVANT,c22339232)) or (op==2 and c22339232.spfilter(chkc,e,tp))
	end
	local b1=Duel.IsExistingTarget(aux.FaceupFilter(Card.IsCode,CARD_SKULL_SERVANT,c22339232),tp,LOCATION_REMOVED,0,1,nil)
	local b2=Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c22339232.spfilter,tp,LOCATION_REMOVED,0,1,nil,e,tp)
	if chk==0 then return b1 or b2 end
	local op=Duel.SelectEffect(tp,
		{b1,aux.Stringc22339232(c22339232,1)},
		{b2,aux.Stringc22339232(c22339232,2)})
	e:SetLabel(op)
	if op==1 then
		e:SetCategory(CATEGORY_TOGRAVE)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g=Duel.SelectTarget(tp,aux.FaceupFilter(Card.IsCode,CARD_SKULL_SERVANT,c22339232),tp,LOCATION_REMOVED,0,1,1,nil)
		Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,1,tp,0)
	elseif op==2 then
		e:SetCategory(CATEGORY_SPECIAL_SUMMON)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectTarget(tp,c22339232.spfilter,tp,LOCATION_REMOVED,0,1,1,nil,e,tp)
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,tp,0)
	end
end
function c22339232.effop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) then return end
	local op=e:GetLabel()
	if op==1 then
		--Return 1 of your banished "Skull Servant" or "Wightmare" to the GY
		Duel.SendtoGrave(tc,REASON_EFFECT|REASON_RETURN)
	elseif op==2 then
		--Special Summon 1 of your banished "The Lady in Wight" or "King of the Skull Servants"
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end