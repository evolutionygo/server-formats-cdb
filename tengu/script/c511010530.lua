--クリムゾン・ヘルフレア (Anime)
--Crimson Fire (Anime)
function c511010530.initial_effect(c)
	--reflect
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511010530(c511010530,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511010530.condition)
	e1:SetOperation(c511010530.operation)
	c:RegisterEffect(e1)
end
function c511010530.cfilter(c,ev)
	return c:IsFaceup() and c:GetAttack()>ev
end
function c511010530.condition(e,tp,eg,ep,ev,re,r,rp)
	if rp==tp then return false end
	local e1=Duel.IsPlayerAffectedByEffect(tp,EFFECT_REVERSE_DAMAGE)
	local e2=Duel.IsPlayerAffectedByEffect(tp,EFFECT_REVERSE_RECOVER)
	local rd=e1 and not e2
	local rr=not e1 and e2
	local ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_DAMAGE)
	if ex and (cp==tp or cp==PLAYER_ALL) and not rd and not Duel.IsPlayerAffectedByEffect(tp,EFFECT_NO_EFFECT_DAMAGE) then
		return Duel.IsExistingMatchingCard(c511010530.cfilter,tp,LOCATION_MZONE,0,1,nil,cv)
	end
	ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_RECOVER)
	return ex and (cp==tp or cp==PLAYER_ALL) and rr and not Duel.IsPlayerAffectedByEffect(tp,EFFECT_NO_EFFECT_DAMAGE)
		and Duel.IsExistingMatchingCard(c511010530.cfilter,tp,LOCATION_MZONE,0,1,nil,cv)
end
function c511010530.operation(e,tp,eg,ep,ev,re,r,rp)
	local cc511010530=Duel.GetChainInfo(ev,CHAININFO_CHAIN_ID)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_REFLECT_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetLabel(cc511010530)
	e1:SetValue(c511010530.refcon)
	e1:SetReset(RESET_CHAIN)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CHANGE_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(0,1)
	e2:SetLabel(cc511010530)
	e2:SetValue(c511010530.dammul)
	e2:SetReset(RESET_CHAIN)
	Duel.RegisterEffect(e2,tp)
end
function c511010530.refcon(e,re,val,r,rp,rc)
	local cc=Duel.GetCurrentChain()
	if cc==0 or (r&REASON_EFFECT)==0 then return end
	local cc511010530=Duel.GetChainInfo(0,CHAININFO_CHAIN_ID)
	return cc511010530==e:GetLabel()
end
function c511010530.dammul(e,re,val,r,rp,rc)
	local cc=Duel.GetCurrentChain()
	if cc==0 or (r&REASON_EFFECT)==0 then return end
	local cc511010530=Duel.GetChainInfo(0,CHAININFO_CHAIN_ID)
	return cc511010530==e:GetLabel() and val*2 or val
end