--リボルバー・ドラゴン
--Barrel Dragon
function c81480460.initial_effect(c)
	--Toss a coin and destroy 1 monster
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc81480460(c81480460,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_COIN+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c81480460.destg)
	e1:SetOperation(c81480460.desop)
	c:RegisterEffect(e1)
end
c81480460.toss_coin=true
function c81480460.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(nil,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,nil,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,3)
end
function c81480460.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local heads=Duel.CountHeads(Duel.TossCoin(tp,3))
		if heads<2 then return end
		Duel.Destroy(tc,REASON_EFFECT)
	end
end