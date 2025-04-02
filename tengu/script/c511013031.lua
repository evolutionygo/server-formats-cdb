--タスケルトン (Anime)
--Bacon Saver (Anime)
--fixed by MLD
function c511013031.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511013031(95360850,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_BATTLE_START)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetHintTiming(TIMING_BATTLE_PHASE)
	e1:SetCost(aux.bfgcost)
	e1:SetCondition(c511013031.atkcon)
	e1:SetTarget(c511013031.atktg)
	e1:SetOperation(c511013031.atkop)
	c:RegisterEffect(e1)
end
function c511013031.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if a:IsControler(tp) and a:IsRelateToBattle() then
		e:SetLabelObject(a)
		return true
	end
	if d and d:IsControler(tp) and d:IsRelateToBattle() then
		e:SetLabelObject(d)
		return true
	end
	return false
end
function c511013031.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=e:GetLabelObject()
	if chk==0 then return true end
	Duel.SetTargetCard(tc)
end
function c511013031.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
		e2:SetValue(1)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE)
		tc:RegisterEffect(e2)
	end
end