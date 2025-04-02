--蟲惑の落とし穴
--Traptrix Trap Hole Nightmare
function c29616929.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc29616929(c29616929,0))
	e1:SetCategory(CATEGORY_DISABLE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c29616929.condition)
	e1:SetTarget(c29616929.target)
	e1:SetOperation(c29616929.activate)
	c:RegisterEffect(e1)
end
function c29616929.condition(e,tp,eg,ep,ev,re,r,rp)
	local loc,status,controller=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION,CHAININFO_TRIGGERING_STATUS,CHAININFO_TRIGGERING_CONTROLER)
	return controller==1-tp and status&STATUS_SPSUMMON_TURN>0 and loc==LOCATION_MZONE and Duel.IsChainDisablable(ev)
end
function c29616929.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
	local rc=re:GetHandler()
	if rc:IsDestructable() and rc:IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c29616929.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateEffect(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end