--野望のゴーファー
function c41224658.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc41224658(c41224658,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c41224658.destg)
	e1:SetOperation(c41224658.desop)
	c:RegisterEffect(e1)
end
function c41224658.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,0,LOCATION_MZONE,1,2,nil)
	if Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)==Duel.GetMatchingGroupCount(Card.IsPublic,tp,0,LOCATION_HAND,nil)
		and not Duel.IsExistingMatchingCard(Card.IsMonster,tp,0,LOCATION_HAND,1,nil) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,#g,0,0)
	end
end
function c41224658.cfilter(c)
	return not c:IsPublic() and c:IsMonster()
end
function c41224658.desop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsChainDisablable(0) then
		local sel=1
		local cg=Duel.GetMatchingGroup(c41224658.cfilter,tp,0,LOCATION_HAND,nil)
		Duel.Hint(HINT_SELECTMSG,1-tp,aux.Stringc41224658(c41224658,1))
		if #cg>0 then
			sel=Duel.SelectOption(1-tp,1213,1214)
		else
			sel=Duel.SelectOption(1-tp,1214)+1
		end
		if sel==0 then
			Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_CONFIRM)
			local sg=cg:Select(1-tp,1,1,nil)
			Duel.ConfirmCards(tp,sg)
			Duel.ShuffleHand(1-tp)
			Duel.NegateEffect(0)
			return
		end
	end
	local g=Duel.GetTargetCards(e)
	Duel.Destroy(g,REASON_EFFECT)
end