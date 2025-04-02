--コンフュージョン・チャフ
function c67630339.initial_effect(c)
	--damage cal
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c67630339.condition)
	e1:SetOperation(c67630339.operation)
	c:RegisterEffect(e1)
	aux.GlobalCheck(s,function()
		s[0]=0
		s[1]=0
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_ATTACK_ANNOUNCE)
		ge1:SetOperation(c67630339.check)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ATTACK_DISABLED)
		ge2:SetOperation(c67630339.check2)
		Duel.RegisterEffect(ge2,0)
		aux.AddValuesReset(function()
			s[0]=0
			s[1]=0
		end)
	end)
end
function c67630339.check(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	if Duel.GetAttackTarget()==nil then
		s[1-tc:GetControler()]=s[1-tc:GetControler()]+1
		Duel.GetAttacker():RegisterFlagEffect(c67630339,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
		if s[1-tc:GetControler()]==1 then
			s[2]=Duel.GetAttacker()
		end
	end
end
function c67630339.check2(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	if tc:GetFlagEffect(c67630339)~=0 and Duel.GetAttackTarget()~=nil then
		s[1-tc:GetControler()]=s[1-tc:GetControler()]-1
	end
end
function c67630339.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and Duel.GetAttackTarget()==nil and s[tp]==2
		and s[2]:GetFlagEffect(c67630339)~=0 and Duel.GetAttacker()~=s[2]
end
function c67630339.operation(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=s[2]
	if a:GetFlagEffect(c67630339)~=0 and d:GetFlagEffect(c67630339)~=0 
		and a:CanAttack() and not a:IsImmuneToEffect(e) and not d:IsImmuneToEffect(e) then
		Duel.CalculateDamage(a,d)
	end
end