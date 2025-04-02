--バルーン・リザード
--Balloon Lizard
function c39892082.initial_effect(c)
	c:EnableCounterPermit(0x29)
	--counter
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc39892082(c39892082,0))
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c39892082.addccon)
	e1:SetTarget(c39892082.addct)
	e1:SetOperation(c39892082.addc)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_LEAVE_FIELD_P)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetOperation(c39892082.regop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringc39892082(c39892082,1))
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCondition(c39892082.damcon)
	e3:SetTarget(c39892082.damtg)
	e3:SetOperation(c39892082.damop)
	e3:SetLabelObject(e2)
	c:RegisterEffect(e3)
end
function c39892082.addccon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c39892082.addct(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,nil,1,0,0x29)
end
function c39892082.addc(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		e:GetHandler():AddCounter(0x29,1)
	end
end
function c39892082.regop(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetHandler():GetCounter(0x29)
	e:SetLabel(ct)
end
function c39892082.damcon(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetLabelObject():GetLabel()
	e:SetLabel(ct)
	return ct>0
end
function c39892082.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(rp)
	Duel.SetTargetParam(e:GetLabel()*400)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,rp,e:GetLabel()*400)
end
function c39892082.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end