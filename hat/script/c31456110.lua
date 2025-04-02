--ヴェルズ・ゴーレム
--Evilswarm Golem
function c31456110.initial_effect(c)
	--Destroy 1 Level 5 or higher non-DARK monster on the field
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc31456110(c31456110,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c31456110.destg)
	e1:SetOperation(c31456110.desop)
	c:RegisterEffect(e1)
end
function c31456110.desfilter(c)
	return c:IsFaceup() and c:IsAttributeExcept(ATTRIBUTE_DARK) and c:IsLevelAbove(5)
end
function c31456110.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c31456110.desfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c31456110.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c31456110.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c31456110.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and c31456110.desfilter(tc) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end