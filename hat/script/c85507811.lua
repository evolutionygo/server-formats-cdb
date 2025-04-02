--Ｅ・ＨＥＲＯ グロー・ネオス
--Elemental HERO Glow Neos
function c85507811.initial_effect(c)
	--Must be properly summoned before reviving
	c:EnableReviveLimit()
	--Contact fusion procedure
	aux.AddFusionProcCode2(c,true,true,CARD_NEOS,17732278)
	Fusion.AddContactProc(c,c85507811.contactfil,c85507811.contactop,c85507811.splimit)
	--Return itself to extra deck during end phase
	aux.EnableNeosReturn(c)
	--Destroy 1 of opponent's cards, then apply appropriate effect, based on the card type
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringc85507811(c85507811,1))
	e5:SetCategory(CATEGORY_DESTROY)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCountLimit(1)
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e5:SetCondition(c85507811.descon)
	e5:SetTarget(c85507811.destg)
	e5:SetOperation(c85507811.desop)
	c:RegisterEffect(e5)
end
c85507811.listed_names={CARD_NEOS}
c85507811.material_setcode={0x8,0x3008,0x9,0x1f}
function c85507811.contactfil(tp)
	return Duel.GetMatchingGroup(Card.IsAbleToDeckOrExtraAsCost,tp,LOCATION_ONFIELD,0,nil)
end
function c85507811.contactop(g,tp)
	Duel.ConfirmCards(1-tp,g)
	Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_COST+REASON_MATERIAL)
end
function c85507811.splimit(e,se,sp,st)
	return not e:GetHandler():IsLocation(LOCATION_EXTRA)
end
function c85507811.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1
end
function c85507811.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c85507811.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Destroy(tc,REASON_EFFECT)
		local c=e:GetHandler()
		if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
		--Cannot attack this turn
		if tc:IsMonster() then
			local e1=Effect.CreateEffect(c)
			e1:SetDescription(3206)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CLIENT_HINT)
			e1:SetCode(EFFECT_CANNOT_ATTACK)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			c:RegisterEffect(e1)
		--Can attack directly this turn
		elseif tc:IsSpell() then
			local e1=Effect.CreateEffect(c)
			e1:SetDescription(3205)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CLIENT_HINT)
			e1:SetCode(EFFECT_DIRECT_ATTACK)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			c:RegisterEffect(e1)
		--Change itself to defense position
		else
			Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
		end
	end
end