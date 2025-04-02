--ドンヨリボー＠イグニスター (Anime)
--Donyoribo @Ignister (Anime)
--Scripted by Larry126
local s,c511600315,alias=GetID()
function c511600315.initial_effect(c)
	alias=c:GetOriginalCodeRule()
	--Battle Damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,alias)
	e1:SetCondition(c511600315.condition)
	e1:SetCost(c511600315.cost)
	e1:SetOperation(c511600315.operation)
	c:RegisterEffect(e1)
	--Effect Damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_QUICK_F)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetCountLimit(1,{alias,1})
	e2:SetCondition(c511600315.damcon)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c511600315.damtg)
	e2:SetOperation(c511600315.damop)
	c:RegisterEffect(e2)
end
c511600315.listed_series={0x135}
function c511600315.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttackTarget()
	return tc and tc:IsControler(tp) and tc:IsSetCard(0x135) and Duel.GetBattleDamage(tp)>0
end
function c511600315.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c511600315.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetOperation(c511600315.bdop)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
end
function c511600315.bdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(tp,0)
end
function c511600315.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x135)
end
function c511600315.damcon(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsExistingMatchingCard(c511600315.cfilter,tp,LOCATION_MZONE,0,1,nil) then return false end
	for p=0,1 do
		local e1=Duel.IsPlayerAffectedByEffect(p,EFFECT_REVERSE_DAMAGE)
		local e2=Duel.IsPlayerAffectedByEffect(p,EFFECT_REVERSE_RECOVER)
		local rd=e1 and not e2
		local rr=not e1 and e2
		local ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_DAMAGE)
		if ex and (cp==p or p==PLAYER_ALL) and not rd and not Duel.IsPlayerAffectedByEffect(p,EFFECT_NO_EFFECT_DAMAGE) then
			return true
		end
		ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_RECOVER)
		if ex and (p==tp or p==PLAYER_ALL) and rr and not Duel.IsPlayerAffectedByEffect(p,EFFECT_NO_EFFECT_DAMAGE) then
			return true
		end
	end
	return false
end
function c511600315.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	e:SetLabel(Duel.SelectOption(tp,aux.Stringc511600315(c511600315,0),aux.Stringc511600315(c511600315,1)))
end
function c511600315.damop(e,tp,eg,ep,ev,re,r,rp)
	local op=e:GetLabel()
	local cc511600315=Duel.GetChainInfo(ev,CHAININFO_CHAIN_ID)
	if op==0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_CHANGE_DAMAGE)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetTargetRange(1,1)
		e1:SetLabel(cc511600315)
		e1:SetValue(c511600315.damval)
		e1:SetReset(RESET_CHAIN)
		Duel.RegisterEffect(e1,tp)
	elseif op==1 then
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_FIELD)
		e2:SetCode(EFFECT_CHANGE_DAMAGE)
		e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e2:SetTargetRange(1,1)
		e2:SetLabel(cc511600315)
		e2:SetValue(c511600315.damval2)
		e2:SetReset(RESET_CHAIN)
		Duel.RegisterEffect(e2,tp)
	end
end
function c511600315.damval(e,re,val,r,rp,rc)
	local cc=Duel.GetCurrentChain()
	if cc==0 or r&REASON_EFFECT==0 then return val end
	local cc511600315=Duel.GetChainInfo(0,CHAININFO_CHAIN_ID)
	if cc511600315~=e:GetLabel() then return val end
	return 0
end
function c511600315.damval2(e,re,val,r,rp,rc)
	local cc=Duel.GetCurrentChain()
	if cc==0 or r&REASON_EFFECT==0 then return val end
	local cc511600315=Duel.GetChainInfo(0,CHAININFO_CHAIN_ID)
	if cc511600315~=e:GetLabel() then return val end
	return val*2
end