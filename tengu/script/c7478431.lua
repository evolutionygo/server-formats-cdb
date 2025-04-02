--ナチュル・サンフラワー
--Naturia Sunflower
function c7478431.initial_effect(c)
	--Negate effect activation
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc7478431(c7478431,0))
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c7478431.discon)
	e1:SetCost(aux.CostWithReplace(c7478431.discost,CARD_NATURIA_CAMELLIA))
	e1:SetTarget(c7478431.distg)
	e1:SetOperation(c7478431.disop)
	c:RegisterEffect(e1)
end
c7478431.listed_series={0x2a}
function c7478431.discon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and re:IsActiveType(TYPE_MONSTER)
		and Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)~=LOCATION_DECK and Duel.IsChainNegatable(ev)
end
function c7478431.cfilter(c)
	return c:IsSetCard(0x2a) and not c:IsStatus(STATUS_BATTLE_DESTROYED)
end
function c7478431.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsReleasable() and not c:IsStatus(STATUS_BATTLE_DESTROYED)
		and Duel.CheckReleaseGroupCost(tp,c7478431.cfilter,1,false,nil,c) end
	local g=Duel.SelectReleaseGroupCost(tp,c7478431.cfilter,1,1,false,nil,c)
	Duel.Release(g:AddCard(c),REASON_COST)
end
function c7478431.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	local rc=re:GetHandler()
	if rc:IsDestructable() and rc:IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c7478431.disop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end