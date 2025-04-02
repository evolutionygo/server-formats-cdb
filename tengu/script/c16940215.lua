--ナチュル・ナーブ
--Naturia Vein
function c16940215.initial_effect(c)
	--Negate Spell/Trap Card activation
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc16940215(c16940215,0))
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c16940215.discon)
	e1:SetCost(aux.CostWithReplace(c16940215.discost,CARD_NATURIA_CAMELLIA))
	e1:SetTarget(c16940215.distg)
	e1:SetOperation(c16940215.disop)
	c:RegisterEffect(e1)
	aux.DoubleSnareValc16940215ity(c,LOCATION_MZONE)
end
c16940215.listed_series={0x2a}
function c16940215.discon(e,tp,eg,ep,ev,re,r,rp)
	return ep==1-tp and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev)
end
function c16940215.cfilter(c)
	return c:IsSetCard(0x2a) and not c:IsStatus(STATUS_BATTLE_DESTROYED)
end
function c16940215.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsReleasable() and not c:IsStatus(STATUS_BATTLE_DESTROYED)
		and Duel.CheckReleaseGroupCost(tp,c16940215.cfilter,1,false,nil,c) end
	local g=Duel.SelectReleaseGroupCost(tp,c16940215.cfilter,1,1,false,nil,c)
	Duel.Release(g:AddCard(c),REASON_COST)
end
function c16940215.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	local rc=re:GetHandler()
	if rc:IsDestructable() and rc:IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c16940215.disop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end