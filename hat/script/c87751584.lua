--ガトリング・ドラゴン
--Gatling Dragon
function c87751584.initial_effect(c)
	--Fusion Summon Procedure
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,true,true,81480460,25551951)
	--Toss 3 coins and destroy monsters on the field
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc87751584(c87751584,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_COIN)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c87751584.destg)
	e1:SetOperation(c87751584.desop)
	c:RegisterEffect(e1)
end
c87751584.toss_coin=true
function c87751584.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(nil,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,3)
end
function c87751584.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(nil,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if #g==0 then return end
	local ct=Duel.CountHeads(Duel.TossCoin(tp,3))
	if ct==0 then return end
	if ct>#g then ct=#g end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local dg=g:Select(tp,ct,ct,nil)
	Duel.HintSelection(dg)
	Duel.Destroy(dg,REASON_EFFECT)
end