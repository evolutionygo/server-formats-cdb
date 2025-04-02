--強欲な壺の精霊
--Spirit of the Pot of Greed
function c4896788.initial_effect(c)
	--The player that activates "Pot of Greed" can draw 1 card
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc4896788(c4896788,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c4896788.drcon)
	e1:SetTarget(c4896788.drtg)
	e1:SetOperation(c4896788.drop)
	c:RegisterEffect(e1)
end
c4896788.listed_names={55144522} --"Pot of Greed"
function c4896788.drcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsAttackPos() and re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:GetHandler():IsCode(55144522)
end
function c4896788.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(rp)
	Duel.SetTargetParam(1)
	Duel.SetPossibleOperationInfo(0,CATEGORY_DRAW,nil,0,rp,1)
end
function c4896788.drop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not (c:IsRelateToEffect(e) and c:IsAttackPos() and c:IsFaceup()) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	if Duel.IsPlayerCanDraw(p,d) and Duel.SelectYesNo(p,aux.Stringc4896788(c4896788,1)) then
		Duel.Draw(p,d,REASON_EFFECT)
	end
end