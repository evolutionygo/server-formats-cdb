--旧神の印
--Seal of the Ancients (Rush)
function c160001040.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c160001040.cost)
	e1:SetTarget(c160001040.target)
	e1:SetOperation(c160001040.activate)
	c:RegisterEffect(e1)
end
function c160001040.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
end
function c160001040.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFacedown,tp,0,LOCATION_ONFIELD,1,nil) end
end
function c160001040.activate(e,tp,eg,ep,ev,re,r,rp)
	--requirement
	Duel.PayLPCost(tp,1000)
	--effect
	local g=Duel.GetMatchingGroup(Card.IsFacedown,tp,0,LOCATION_ONFIELD,nil)
	if #g>0 then
		Duel.ConfirmCards(tp,g)
	end
end