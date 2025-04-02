--トラップ・マスター
--Trap Master
function c46461247.initial_effect(c)
	--Destroy 1 Trap card on the field
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc46461247(c46461247,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c46461247.target)
	e1:SetOperation(c46461247.operation)
	c:RegisterEffect(e1)
end
function c46461247.filter(c)
	return c:IsTrap() or (c:IsFacedown() and c:IsLocation(LOCATION_STZONE))
end
function c46461247.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_ONFIELD) and c46461247.filter(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c46461247.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	if #g>0 and g:GetFirst():IsFaceup() then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	end
end
function c46461247.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		if tc:IsFacedown() then Duel.ConfirmCards(tp,tc) end
		if tc:IsTrap() then
			Duel.Destroy(tc,REASON_EFFECT)
		end
	end
end