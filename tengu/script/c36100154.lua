--アマゾネスの闘志
--Amazoness Fighting Spirit
function c36100154.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--"Amazoness" monsters gain 1000 ATK during Damage Calculation
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCondition(c36100154.atkcon)
	e2:SetTarget(c36100154.atktg)
	e2:SetValue(c36100154.atkval)
	c:RegisterEffect(e2)
end
c36100154.listed_series={SET_AMAZONESS}
function c36100154.atkcon(e)
	s[0]=false
	return Duel.GetCurrentPhase()==PHASE_DAMAGE_CAL and Duel.GetAttackTarget()
end
function c36100154.atktg(e,c)
	return c==Duel.GetAttacker() and c:IsSetCard(SET_AMAZONESS)
end
function c36100154.atkval(e,c)
	local d=Duel.GetAttackTarget()
	if s[0] or c:GetAttack()<d:GetAttack() then
		s[0]=true
		return 1000
	else return 0 end
end