--神秘の中華なべ
--Mystik Wok
function c80161395.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc80161395(c80161395,0))
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER_E)
	e1:SetCost(c80161395.cost)
	e1:SetTarget(c80161395.target)
	e1:SetOperation(c80161395.activate)
	c:RegisterEffect(e1)
end
function c80161395.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return true end
end
function c80161395.costfilter(c)
	return c:GetAttack()>0 or c:GetDefense()>0
end
function c80161395.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return Duel.CheckReleaseGroupCost(tp,c80161395.costfilter,1,false,nil,nil)
	end
	local sc=Duel.SelectReleaseGroupCost(tp,c80161395.costfilter,1,1,false,nil,nil):GetFirst()
	local atk=sc:GetAttack()
	local def=sc:GetDefense()
	Duel.Release(sc,REASON_COST)
	local op=nil
	local b1=atk>0
	local b2=def>0
	if b1 and b2 then
		op=Duel.SelectEffect(tp,
			{b1,aux.Stringc80161395(c80161395,1)},
			{b2,aux.Stringc80161395(c80161395,2)})
	else
		op=b1 and 1 or 2
	end
	local val=op==1 and atk or def
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(val)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,val)
end
function c80161395.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_EFFECT)
end