--充電機塊セルトパス (Anime)
--Appliancer Celtopus (Anime)
--Scripted by pyrQ
function c511030044.initial_effect(c)
	--Link Summon
	c:EnableReviveLimit()
	Link.AddProcedure(c,c511030044.matfilter,2)
	--cannot be targeted by attacks
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e1:SetCondition(c511030044.imcon)
	e1:SetValue(aux.imval1)
	c:RegisterEffect(e1)
	--cannot be targeted by effects
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetValue(aux.tgoval)
	c:RegisterEffect(e2)
	--increase ATK
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_FIELD)
	e3:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c511030044.atkcon)
	e3:SetOperation(c511030044.atkop)
	c:RegisterEffect(e3)
	--co-linked before destruction check
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_LEAVE_FIELD_P)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(c511030044.checkcon)
	e4:SetOperation(c511030044.checkop)
	c:RegisterEffect(e4)
	--Draw
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_DRAW)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_DESTROYED)
	e5:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCountLimit(1,c:Alias())
	e5:SetCondition(c511030044.drcon)
	e5:SetTarget(c511030044.drtg)
	e5:SetOperation(c511030044.drop)
	c:RegisterEffect(e5)
end
c511030044.listed_series={0x14a}
function c511030044.matfilter(c,lc,sumtype,tp)
	return c:IsLevel(1) and c:IsSetCard(0x14a,lc,sumtype,tp)
end
function c511030044.imcon(e)
	return e:GetHandler():IsLinked()
end
function c511030044.cfilter(c)
	return c:IsFacedown() or not c:IsSetCard(0x14a)
end
function c511030044.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local b=Duel.GetAttackTarget()
	if not (a and b) then return false end
	if a:IsControler(1-tp) then
		a=Duel.GetAttackTarget()
		b=Duel.GetAttacker()
	end
	local mg=a:GetMutualLinkedGroup()
	local octg=e:GetHandler():GetMutualLinkedGroup()
	return a and a:IsControler(tp) and a:IsLinkMonster() and a~=e:GetHandler() and b and b:IsControler(1-tp)
		and mg:IsContains(e:GetHandler()) and octg:IsContains(a)
		and not Duel.IsExistingMatchingCard(c511030044.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511030044.atkop(e,tp,eg,ep,ev,re,r,rp)
	local atkct=e:GetHandler():GetMutualLinkedGroupCount()
	local a=Duel.GetAttacker()
	local b=Duel.GetAttackTarget()
	if a:IsControler(1-tp) then
		a=Duel.GetAttackTarget()
		b=Duel.GetAttacker()
	end
	if a and a:IsRelateToBattle() and a:IsFaceup() and a:IsControler(tp) and atkct>0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
		e1:SetValue(atkct*1000)
		a:RegisterEffect(e1)
	end
end
function c511030044.checkfilter(c,e,tp)
	local mg=c:GetMutualLinkedGroup()
	local octg=e:GetHandler():GetMutualLinkedGroup()
	return c:IsSetCard(0x14a) and c:IsControler(tp) and c:IsReason(REASON_DESTROY)
		and c:IsReason(REASON_BATTLE+REASON_EFFECT)
		and not (mg:IsContains(e:GetHandler()) and octg:IsContains(c))
end
function c511030044.checkcon(e,tp,eg,ep,ev,re,r,rp)
	return not eg:IsContains(e:GetHandler()) and eg:IsExists(c511030044.checkfilter,1,e:GetHandler(),e,tp)
end
function c511030044.checkop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(c511030044,RESET_EVENT+RESETS_STANDARD+RESET_CHAIN,0,1)
end
function c511030044.drcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(c511030044)>0
end
function c511030044.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c511030044.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end