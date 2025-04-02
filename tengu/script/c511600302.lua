--アチチ＠イグニスター (Anime)
--Achichi @Ignister (Anime)
--Scripted by Larry126
function c511600302.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLED)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c511600302.condition)
	e1:SetCost(aux.bfgcost)
	e1:SetTarget(c511600302.target)
	e1:SetOperation(c511600302.operation)
	c:RegisterEffect(e1)
end
function c511600302.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttackTarget()
	if not tc then return false end
	if not tc:IsControler(tp) then tc=Duel.GetAttacker() end
	return tc:IsControler(tp) and tc:IsAttribute(ATTRIBUTE_FIRE) and tc:IsStatus(STATUS_BATTLE_DESTROYED)
end
function c511600302.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local tc=Duel.GetAttackTarget()
	if not tc:IsControler(tp) then tc=Duel.GetAttacker() end
	Duel.SetTargetCard(tc)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tc,1,0,0)
end
function c511600302.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsControler(tp) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end