--王家の神殿
--Temple of the Kings
function c29762407.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Allow 1 Trap card to be activated the turn it was Set
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc29762407(c29762407,1))
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_TRAP_ACT_IN_SET_TURN)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_SZONE,0)
	e2:SetCountLimit(1,c29762407)
	c:RegisterEffect(e2)
	--Special Summon 1 monster from the hand, Deck or Extra Deck
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringc29762407(c29762407,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1,{c29762407,1})
	e3:SetCost(c29762407.cost)
	e3:SetTarget(c29762407.target)
	e3:SetOperation(c29762407.operation)
	c:RegisterEffect(e3)
end
c29762407.listed_names={89194033}
function c29762407.cfilter(c,e,tp,rp)
	if c:IsFacedown() or not c:IsCode(89194033) or not c:IsAbleToGraveAsCost() then return false end
	return Duel.IsExistingMatchingCard(c29762407.filter,tp,LOCATION_DECK|LOCATION_HAND|LOCATION_EXTRA,0,1,nil,e,tp,rp,Group.FromCards(c,e:GetHandler()))
end
function c29762407.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost()
		and Duel.IsExistingMatchingCard(c29762407.cfilter,tp,LOCATION_ONFIELD,0,1,nil,e,tp,rp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c29762407.cfilter,tp,LOCATION_ONFIELD,0,1,1,nil,e,tp,rp)
	g:AddCard(e:GetHandler())
	Duel.SendtoGrave(g,REASON_COST)
end
function c29762407.filter(c,e,tp,rp,sg)
	if not c:IsCanBeSpecialSummoned(e,0,tp,false,false) then return false end
	if c:IsLocation(LOCATION_HAND|LOCATION_DECK) then
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	else
		return c:IsType(TYPE_FUSION) and Duel.GetLocationCountFromEx(tp,rp,sg,c)>0
	end
end
function c29762407.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK|LOCATION_HAND|LOCATION_EXTRA)
end
function c29762407.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c29762407.filter,tp,LOCATION_DECK|LOCATION_HAND|LOCATION_EXTRA,0,1,1,nil,e,tp,rp)
	if #g>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end