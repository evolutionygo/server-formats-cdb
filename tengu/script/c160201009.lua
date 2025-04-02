--右手に盾を左手に剣を
--Shield & Sword (Rush)
function c160201009.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c160201009.target)
	e1:SetOperation(c160201009.activate)
	c:RegisterEffect(e1)
end
function c160201009.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:IsHasType(EFFECT_TYPE_ACTIVATE)
		and Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.HasDefense),tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(aux.FaceupFilter(Card.HasDefense),tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetTargetCard(g)
end
function c160201009.filter(c,e)
	return c:IsFaceup() and c:HasDefense() and c:IsRelateToEffect(e) and not c:IsImmuneToEffect(e)
end
function c160201009.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c160201009.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,e)
	if #sg==0 then return end
	for tc in sg:Iter() do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SWAP_BASE_AD)
		e1:SetReset(RESETS_STANDARD_PHASE_END)
		tc:RegisterEffect(e1)
	end
end