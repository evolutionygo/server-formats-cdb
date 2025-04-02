--ゴッドハンド・スマッシュ
--Kaminote Blow
function c97570038.initial_effect(c)
	--Destroy the monsters that battle with your monsters this turn
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc97570038(c97570038,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c97570038.condition)
	e1:SetOperation(c97570038.operation)
	c:RegisterEffect(e1)
end
c97570038.listed_names={8508055,3810071,49814180} --Chu-Ske the Mouse Fighter, Monk Fighter, Master Monk
function c97570038.filter(c)
	return c:IsFaceup() and c:IsCode(8508055,3810071,49814180)
end
function c97570038.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c97570038.filter,tp,LOCATION_MZONE,0,1,nil)
end
function c97570038.operation(e,tp,eg,ep,ev,re,r,rp)
	--Destroy
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_DAMAGE_STEP_END)
	e1:SetOperation(c97570038.desop)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c97570038.cfilter(c,tp)
	return c:IsCode(8508055,3810071,49814180) and c:IsControler(tp)
end
function c97570038.desop(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local at=Duel.GetAttackTarget()
	if not at then return end
	local g=Group.CreateGroup()
	if c97570038.cfilter(a,tp) and at:IsLocation(LOCATION_MZONE) then g:AddCard(at) end
	if c97570038.cfilter(at,tp) and a:IsLocation(LOCATION_MZONE) then g:AddCard(a) end
	if #g>0 then
		Duel.Destroy(g,REASON_EFFECT)
	end
end