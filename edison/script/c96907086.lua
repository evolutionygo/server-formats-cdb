--地縛旋風
--Earthbound Whirlwind
function c96907086.initial_effect(c)
	--Destroy all Spell/traps your opponent controls
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc96907086(c96907086,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c96907086.condition)
	e1:SetTarget(c96907086.target)
	e1:SetOperation(c96907086.activate)
	c:RegisterEffect(e1)
end
c96907086.listed_series={SET_EARTHBOUND_IMMORTAL}
function c96907086.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsSetCard,SET_EARTHBOUND_IMMORTAL),tp,LOCATION_MZONE,0,1,nil)
end
function c96907086.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsSpellTrap,tp,0,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(Card.IsSpellTrap,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,#g,0,0)
end
function c96907086.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsSpellTrap,tp,0,LOCATION_ONFIELD,nil)
	Duel.Destroy(g,REASON_EFFECT)
end