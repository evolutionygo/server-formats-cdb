--バルーン・リザード
--Balloon Lizard (GOAT)
--Battle destroyed registers while the monster is on field
function c504700065.initial_effect(c)
	c:EnableCounterPermit(0x29)
	--counter
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc504700065(c504700065,0))
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c504700065.addccon)
	e1:SetTarget(c504700065.addct)
	e1:SetOperation(c504700065.addc)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_LEAVE_FIELD_P)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetOperation(c504700065.regop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringc504700065(c504700065,1))
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_BATTLED)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCondition(c504700065.damcon2)
	e3:SetTarget(c504700065.damtg2)
	e3:SetOperation(c504700065.damop)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_DESTROYED)
	e4:SetCondition(c504700065.damcon)
	e4:SetTarget(c504700065.damtg)
	e4:SetLabelObject(e2)
	c:RegisterEffect(e4)
end
function c504700065.addccon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c504700065.addct(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,nil,1,0,0x29)
end
function c504700065.addc(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		e:GetHandler():AddCounter(0x29,1)
	end
end
function c504700065.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsBattleDestroyed() then return end
	local ct=c:GetCounter(0x29)
	e:SetLabel(ct)
end
function c504700065.damcon(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsBattleDestroyed() then return false end
	local ct=e:GetLabelObject():GetLabel()
	e:SetLabel(ct)
	return ct>0
end
function c504700065.damcon2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsBattleDestroyed() then return false end
	local ct=c:GetCounter(0x29)
	e:SetLabel(ct)
	return ct>0
end
function c504700065.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(rp)
	Duel.SetTargetParam(e:GetLabel()*400)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,rp,e:GetLabel()*400)
end
function c504700065.damtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local other=Duel.GetAttacker()
	if other==e:GetHandler() then other=Duel.GetAttackTarget() end
	Duel.SetTargetPlayer(other:GetControler())
	Duel.SetTargetParam(e:GetLabel()*400)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,other:GetControler(),e:GetLabel()*400)
end
function c504700065.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end