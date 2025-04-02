--皇の波動
--Utopian Aura
function c59070329.initial_effect(c)
	--Your Xyz monsters cannot be destroyed by card effects
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c59070329.cost)
	e1:SetTarget(c59070329.target)
	e1:SetOperation(c59070329.activate)
	e1:SetHintTiming(0,TIMING_STANDBY_PHASE+TIMING_END_PHASE)
	c:RegisterEffect(e1)
end
function c59070329.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckRemoveOverlayCard(tp,1,0,1,REASON_COST) end
	Duel.RemoveOverlayCard(tp,1,0,1,1,REASON_COST)
end
function c59070329.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c59070329.filter,tp,LOCATION_MZONE,0,1,nil) end
end
function c59070329.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c59070329.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c59070329.filter,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	for tc in aux.Next(g) do
		--Cannot be destroyed by card effect
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetDescription(3001)
		e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end