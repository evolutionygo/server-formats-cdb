--でんきトカゲ
--Electric Lizard
function c55875323.initial_effect(c)
	--A non-zombie monster that attacked this card cannot attack next turn
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc55875323(c55875323,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLED)
	e1:SetCondition(c55875323.condition)
	e1:SetOperation(c55875323.operation)
	c:RegisterEffect(e1)
end
function c55875323.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler()==Duel.GetAttackTarget() and not Duel.GetAttacker():IsRace(RACE_ZOMBIE)
end
function c55875323.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetAttacker()
	if tc:IsRelateToBattle() then
		--Cannot attack
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(3206)
		e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_ATTACK)
		e1:SetLabel(Duel.GetTurnCount())
		e1:SetCondition(c55875323.atkcon)
		e1:SetOwnerPlayer(tp)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END+RESET_OPPO_TURN,2)
		tc:RegisterEffect(e1)
	end
end
function c55875323.atkcon(e)
	return Duel.GetTurnCount()~=e:GetLabel() and Duel.GetTurnPlayer()~=e:GetOwnerPlayer()
end