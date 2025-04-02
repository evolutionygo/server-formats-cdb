--魔法族の聖域
--Secret Sanctuary of the Spellcasters
function c25407643.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Destroy itself if you control no spellcaster monsters
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EFFECT_SELF_DESTROY)
	e2:SetCondition(c25407643.descon)
	c:RegisterEffect(e2)
	--When a monster is normal summoned to opponent's field, it cannot attack or activate its effects
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc25407643(c25407643,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c25407643.condition)
	e2:SetTarget(c25407643.target)
	e2:SetOperation(c25407643.operation)
	c:RegisterEffect(e2)
	--Same as above, but when special summoned
	local e4=e2:Clone()
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e4)
end
function c25407643.descon(e)
	return not Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsRace,RACE_SPELLCASTER),e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c25407643.cfilter1(c)
	return c:IsFaceup() and c:IsSpell()
end
function c25407643.cfilter2(c,tp)
	return c:IsFaceup() and not c:IsRace(RACE_SPELLCASTER) and c:IsControler(tp)
end
function c25407643.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c25407643.cfilter1,tp,LOCATION_SZONE,0,1,e:GetHandler())
		and not Duel.IsExistingMatchingCard(c25407643.cfilter1,tp,0,LOCATION_SZONE,1,nil)
		and eg:IsExists(c25407643.cfilter2,1,nil,1-tp)
end
function c25407643.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsRelateToEffect(e) end
	Duel.SetTargetCard(eg)
end
function c25407643.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if not Duel.IsExistingMatchingCard(c25407643.cfilter1,tp,LOCATION_SZONE,0,1,e:GetHandler())
		or Duel.IsExistingMatchingCard(c25407643.cfilter1,tp,0,LOCATION_SZONE,1,nil) then return end
	local tc=eg:GetFirst()
	local c=e:GetHandler()
	for tc in aux.Next(eg) do
		if tc:IsRelateToEffect(e) and c25407643.cfilter2(tc,1-tp) then
			--Cannot attack
			local e1=Effect.CreateEffect(c)
			e1:SetDescription(3206)
			e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CANNOT_ATTACK)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e1)
			--Cannot activate its effects
			local e2=Effect.CreateEffect(c)
			e2:SetDescription(3302)
			e2:SetProperty(EFFECT_FLAG_CLIENT_HINT)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_CANNOT_TRIGGER)
			e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e2)
		end
	end
end