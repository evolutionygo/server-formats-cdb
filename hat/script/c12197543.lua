--剣の采配
--Commander of Swords
function c12197543.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc12197543(c12197543,0))
	e1:SetCategory(CATEGORY_HANDES+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DRAW)
	e1:SetCondition(c12197543.condition)
	e1:SetTarget(c12197543.target)
	e1:SetOperation(c12197543.activate)
	c:RegisterEffect(e1)
end
function c12197543.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep==1-tp and r==REASON_RULE
end
function c12197543.filter(c,e)
	return c:IsLocation(LOCATION_HAND) and not c:IsPublic() and (not e or c:IsRelateToEffect(e))
end
function c12197543.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c12197543.filter,1,nil) end
	Duel.SetTargetCard(eg)
	Duel.SetPossibleOperationInfo(0,CATEGORY_HANDES,nil,0,1-tp,1)
	Duel.SetPossibleOperationInfo(0,CATEGORY_DESTROY,nil,1,1-tp,LOCATION_ONFIELD)
end
function c12197543.activate(e,tp,eg,ep,ev,re,r,rp)
	local rg=eg:Filter(c12197543.filter,nil,e)
	if #rg==0 then return end
	Duel.ConfirmCards(tp,rg)
	if not rg:IsExists(Card.IsSpellTrap,1,nil) then return Duel.ShuffleHand(1-tp) end
	local g=Duel.GetMatchingGroup(Card.IsSpellTrap,tp,0,LOCATION_ONFIELD,nil)
	local b1=rg:FilterCount(Card.IsDiscardable,nil,REASON_EFFECT)==#rg
	local b2=#g>0
	if not (b1 or b2) then return Duel.ShuffleHand(1-tp) end
	local op=Duel.SelectEffect(tp,
		{b1,aux.Stringc12197543(c12197543,1)},
		{b2,aux.Stringc12197543(c12197543,2)})
	if op==1 then
		Duel.SendtoGrave(rg,REASON_EFFECT+REASON_DISCARD)
	elseif op==2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local dg=g:Select(tp,1,1,nil)
		Duel.HintSelection(dg,true)
		Duel.Destroy(dg,REASON_EFFECT)
		Duel.ShuffleHand(1-tp)
	end
end