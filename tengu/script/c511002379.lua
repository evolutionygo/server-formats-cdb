--摩天楼 －スカイスクレイパー－
--Skyscraper (Anime)
function c511002379.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCondition(c511002379.atkcon)
	e2:SetTarget(c511002379.atktg)
	e2:SetValue(c511002379.atkval)
	c:RegisterEffect(e2)
end
c511002379.listed_series={0x3008}
function c511002379.atkcon(e)
	s[0]=false
	return Duel.GetCurrentPhase()==PHASE_DAMAGE_CAL and Duel.GetAttackTarget() and Duel.GetAttacker()
end
function c511002379.atktg(e,c)
	return (c==Duel.GetAttacker() and c:IsSetCard(0x3008)) or (c==Duel.GetAttackTarget() and c:IsSetCard(0x3008))
end
function c511002379.atkval(e,c)
	local d=Duel.GetAttackTarget()
	if d==c then d=Duel.GetAttacker() end
	if s[0] or c:GetAttack()<d:GetAttack() then
		s[0]=true
		return 1000
	else return 0 end
end