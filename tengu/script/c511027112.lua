--ブラックフェザードラゴン (Anime)
--Black-Winged Dragon (Anime)
--Scripted by Rundas
function c511027112.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,1,1,aux.NonTuner(nil),1,99)
	c:EnableReviveLimit()
	--damage negation battle
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511027112.con1)
	e1:SetTarget(c511027112.tg1)
	e1:SetOperation(c511027112.op1)
	c:RegisterEffect(e1)
	--damage negation card effect
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAIN_SOLVING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c511027112.con2)
	e2:SetTarget(c511027112.tg2)
	e2:SetOperation(c511027112.op2)
	c:RegisterEffect(e2)
	--attack down
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetValue(c511027112.flagval)
	c:RegisterEffect(e3)
	--regain atk + atkdown
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringc511027112(c511027112,0))
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetTarget(c511027112.tg3)
	e4:SetOperation(c511027112.op3)
	c:RegisterEffect(e4)
end
--damage negation battle
function c511027112.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetBattleDamage(tp)>0
end
function c511027112.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:GetAttack()>=Duel.GetBattleDamage(tp) and not c:IsRelateToBattle() end
end
function c511027112.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(tp,c511027112)~=0 then return end
	local c=e:GetHandler()
	if c:GetFlagEffect(c511027112)==0 then c:RegisterFlagEffect(c511027112,RESET_EVENT+RESETS_STANDARD,0,1,0) end
	if Duel.SelectEffectYesNo(tp,c) then
		Duel.HintSelection(Group.FromCards(c))
		Duel.Hint(HINT_CARD,1-tp,c511027112)
		Duel.RegisterFlagEffect(tp,c511027112,RESET_PHASE+PHASE_DAMAGE,0,1)
		c:SetFlagEffectLabel(c511027112,c:GetFlagEffectLabel(c511027112)+Duel.GetBattleDamage(tp))
		Duel.ChangeBattleDamage(tp,0)
	end
end
--damage negation card effect
function c511027112.con2(e,tp,eg,ep,ev,re,r,rp)
	local e1=Duel.IsPlayerAffectedByEffect(tp,EFFECT_REVERSE_DAMAGE)
	local e2=Duel.IsPlayerAffectedByEffect(tp,EFFECT_REVERSE_RECOVER)
	local rd=e1 and not e2
	local rr=not e1 and e2
	local ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_DAMAGE)
	if ex and (cp==tp or cp==PLAYER_ALL) and not rd and not Duel.IsPlayerAffectedByEffect(tp,EFFECT_NO_EFFECT_DAMAGE) then
		e:SetLabel(cv)
		return true 
	end
	ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_RECOVER)
	if ex and (cp==tp or cp==PLAYER_ALL) and rr and not Duel.IsPlayerAffectedByEffect(tp,EFFECT_NO_EFFECT_DAMAGE) then
		e:SetLabel(cv)
		return true
	else
		e:SetLabel(0)
		return false
	end
end
function c511027112.tg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetAttack()>=e:GetLabel() end
end
function c511027112.op2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(tp,c511027112)~=0 then return end
	local c=e:GetHandler()
	if c:GetFlagEffect(c511027112)==0 then c:RegisterFlagEffect(c511027112,RESET_EVENT+RESETS_STANDARD,0,1,0) end
	if Duel.SelectEffectYesNo(tp,c) then
		Duel.HintSelection(Group.FromCards(c))
		Duel.Hint(HINT_CARD,1-tp,c511027112)
		Duel.RegisterFlagEffect(tp,c511027112,RESET_CHAIN,0,1)
		c:SetFlagEffectLabel(c511027112,c:GetFlagEffectLabel(c511027112)+e:GetLabel())
		local cc511027112=Duel.GetChainInfo(ev,CHAININFO_CHAIN_ID)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_CHANGE_DAMAGE)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetTargetRange(1,0)
		e1:SetLabel(cc511027112)
		e1:SetValue(c511027112.refcon)
		e1:SetReset(RESET_CHAIN)
		Duel.RegisterEffect(e1,tp)
	end
end
function c511027112.refcon(e,re,val,r,rp,rc)
	local cc=Duel.GetCurrentChain()
	if cc==0 or r~=REASON_EFFECT then return end
	local cc511027112=Duel.GetChainInfo(0,CHAININFO_CHAIN_ID)
	if cc511027112==e:GetLabel() then return 0
	else return val end
end
--attack down
function c511027112.flagval(e,c)
	return e:GetHandler():GetFlagEffectLabel(c511027112) and -e:GetHandler():GetFlagEffectLabel(c511027112) or 0
end
--regain atk + atkdown
function c511027112.tg3(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffectLabel(c511027112) and e:GetHandler():GetFlagEffectLabel(c511027112)>0 and Duel.IsExistingMatchingCard(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) end
end
function c511027112.op3(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsFaceup() or not c:IsRelateToEffect(e) then return end
	for tc in aux.Next(Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)) do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-c:GetFlagEffectLabel(c511027112))
		tc:RegisterEffect(e1)
	end
	c:SetFlagEffectLabel(c511027112,0)
end