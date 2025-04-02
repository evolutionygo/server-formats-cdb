--侵略の汎発感染
--Infestation Pandemic
function c27541267.initial_effect(c)
	--All your "lswarm" monsters are unaffected by other card effects
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c27541267.target)
	e1:SetOperation(c27541267.operation)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	c:RegisterEffect(e1)
end
c27541267.listed_series={0xa}
function c27541267.filter(c)
	return c:IsFaceup() and c:IsSetCard(0xa)
end
function c27541267.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c27541267.filter,tp,LOCATION_MZONE,0,1,nil) end
end
function c27541267.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c27541267.filter,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	for tc in aux.Next(g) do
		--Unaffected by other card effects
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetDescription(3100)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CLIENT_HINT)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCode(EFFECT_IMMUNE_EFFECT)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(c27541267.efilter)
		tc:RegisterEffect(e1)
	end
end
function c27541267.efilter(e,te)
	return te:IsActiveType(TYPE_SPELL+TYPE_TRAP) and te:GetOwner()~=e:GetOwner()
end