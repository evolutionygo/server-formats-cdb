--神の氷結 (Manga)
--The Ice-Bound God (Manga)
--Scripted by Larry126
function c511002184.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511002184.condition)
	e1:SetTarget(c511002184.target)
	e1:SetOperation(c511002184.activate)
	c:RegisterEffect(e1)
end
function c511002184.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and re:IsActiveType(TYPE_MONSTER) and Duel.IsChainDisablable(ev)
		and Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsAttribute,ATTRIBUTE_WATER),tp,LOCATION_MZONE,LOCATION_MZONE,2,nil)
end
function c511002184.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
end
function c511002184.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
end