local cm,m=GetID()
local list={120294100}
cm.name="壮严的火焰之影"
function cm.initial_effect(c)
	RD.AddCodeList(c,list)
	--Atk Up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(m,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(cm.cost)
	e1:SetTarget(cm.target)
	e1:SetOperation(cm.operation)
	c:RegisterEffect(e1)
end
--Atk Up
function cm.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_EFFECT) and c:IsLevelBelow(8)
end
cm.cost=RD.CostPayLP(500)
function cm.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(cm.filter,tp,LOCATION_MZONE,0,1,nil) end
end
function cm.operation(e,tp,eg,ep,ev,re,r,rp)
	RD.SelectAndDoAction(aux.Stringid(m,1),cm.filter,tp,LOCATION_MZONE,0,1,2,nil,function(g)
		g:ForEach(function(tc)
			RD.AttachAtkDef(e,tc,500,0,RESET_EVENT+RESETS_STANDARD)
		end)
	end)
	if Duel.GetFlagEffect(tp,m)~=0 then return end
	RD.CreateCannotActivateEffect(e,aux.Stringid(m,2),cm.aclimit,tp,1,0,RESET_PHASE+PHASE_END)
	Duel.RegisterFlagEffect(tp,m,RESET_PHASE+PHASE_END,0,1)
end
function cm.aclimit(e,re,tp)
	local tc=re:GetHandler()
	return tc:IsCode(list[1])
end