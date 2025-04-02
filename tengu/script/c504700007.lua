--XY－ドラゴン・キャノン
--XY-Dragon Cannon (GOAT)
--Only mosnters in the mzone allowed as material
--nomi monster instead of seminomi + "Cannot be SS from GY"
function c504700007.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,true,true,62651957,65622692)
	Fusion.AddContactProc(c,c504700007.contactfil,c504700007.contactop,true)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringc504700007(c504700007,0))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCost(c504700007.descost)
	e3:SetTarget(c504700007.destg)
	e3:SetOperation(c504700007.desop)
	c:RegisterEffect(e3)
end
function c504700007.contactfil(tp)
	return Duel.GetMatchingGroup(Card.IsAbleToRemoveAsCost,tp,LOCATION_MZONE,0,nil)
end
function c504700007.contactop(g)
	Duel.Remove(g,POS_FACEUP,REASON_COST+REASON_MATERIAL)
end
function c504700007.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c504700007.filter(c)
	return c:IsFaceup() and c:IsSpellTrap()
end
function c504700007.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and c504700007.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c504700007.filter,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c504700007.filter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,#g,0,0)
end
function c504700007.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end