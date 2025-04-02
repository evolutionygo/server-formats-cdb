--エクシーズ・パニッシュ
--Xyz Wrath
function c99064191.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c99064191.target1)
	e1:SetOperation(c99064191.activate1)
	c:RegisterEffect(e1)
	--instant(chain)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc99064191(c99064191,0))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_CHAINING)
	e2:SetCondition(c99064191.condition2)
	e2:SetCost(c99064191.cost2)
	e2:SetTarget(c99064191.target2)
	e2:SetOperation(c99064191.activate2)
	c:RegisterEffect(e2)
end
function c99064191.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	e:SetLabel(0)
	local ct=Duel.GetCurrentChain()
	if ct==1 or not Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsType,TYPE_XYZ),tp,LOCATION_MZONE,0,1,nil)
		or not Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) then return false end
	local pe=Duel.GetChainInfo(ct-1,CHAININFO_TRIGGERING_EFFECT)
	local tc=pe:GetHandler()
	if pe:IsActiveType(TYPE_EFFECT) and tc:IsLevelAbove(5)
		and Duel.IsChainDisablable(ct-1) and Duel.SelectYesNo(tp,aux.Stringc99064191(c99064191,1)) then
		Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
		Duel.SetOperationInfo(0,CATEGORY_DISABLE,tc,1,0,0)
		if tc:IsRelateToEffect(pe) then
			Duel.SetOperationInfo(0,CATEGORY_DESTROY,tc,1,0,0)
		end
		e:SetLabel(1)
		e:GetHandler():RegisterFlagEffect(c99064191,RESETS_STANDARD_PHASE_END,0,1)
	end
end
function c99064191.activate1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if e:GetLabel()~=1 or not c:IsRelateToEffect(e) then return end
	local ct=Duel.GetCurrentChain()
	local te=Duel.GetChainInfo(ct-1,CHAININFO_TRIGGERING_EFFECT)
	local tc=te:GetHandler()
	if Duel.NegateEffect(ct-1) and tc:IsRelateToEffect(te) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c99064191.condition2(e,tp,eg,ep,ev,re,r,rp,chk)
	return Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsType,TYPE_XYZ),tp,LOCATION_MZONE,0,1,nil)
		and re:IsActiveType(TYPE_EFFECT) and re:GetHandler():IsLevelAbove(5) and Duel.IsChainDisablable(ev)
end
function c99064191.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c99064191.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(c99064191)==0 end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
	e:GetHandler():RegisterFlagEffect(c99064191,RESETS_STANDARD_PHASE_END,0,1)
end
function c99064191.activate2(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.NegateEffect(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end