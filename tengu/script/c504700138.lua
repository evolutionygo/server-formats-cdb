--お注射天使リリー
function c504700138.initial_effect(c)
	--attack up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc504700138(c504700138,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c504700138.con)
	e1:SetCost(c504700138.cost)
	e1:SetOperation(c504700138.op)
	c:RegisterEffect(e1)
end
function c504700138.con(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetFlagEffect(c504700138)==0 and (Duel.GetAttacker()==c or Duel.GetAttackTarget()==c)
end
function c504700138.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,2000) end
	Duel.PayLPCost(tp,2000)
	e:GetHandler():RegisterFlagEffect(c504700138,RESET_PHASE+PHASE_DAMAGE_CAL,0,1)
end
function c504700138.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
	e1:SetValue(3000)
	c:RegisterEffect(e1)
end