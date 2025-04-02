--ヘルポーンデーモン
--Vilepawn Archfiend
function c73219648.initial_effect(c)
	--Once per turn, during your Standby Phase, you must pay 500 LP (this is not optional), or this card is destroyed
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(function(e,tp) return Duel.IsTurnPlayer(tp) end)
	e1:SetOperation(c73219648.mtop)
	c:RegisterEffect(e1)
	--Roll a six-sc73219648ed die when resolving an opponent's card effect that targets this card
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAIN_SOLVING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetOperation(c73219648.disop)
	c:RegisterEffect(e2)
	--Your opponent cannot attack "Archfiend" monsters you control, except "Vilpawn Archfiend"
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetValue(c73219648.atktg)
	c:RegisterEffect(e3)
end
c73219648.listed_series={SET_ARCHFIEND}
c73219648.roll_dice=true
c73219648.listed_names={c73219648}
function c73219648.mtop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.CheckLPCost(tp,500) then
		Duel.PayLPCost(tp,500)
	else
		Duel.Destroy(e:GetHandler(),REASON_COST)
	end
end
function c73219648.disop(e,tp,eg,ep,ev,re,r,rp)
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local c=e:GetHandler()
	if not (c:IsRelateToEffect(re) and ep==1-tp) then return end
	local tg=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not tg or not tg:IsContains(c) or not Duel.IsChainDisablable(ev) then return false end
	local rc=re:GetHandler()
	Duel.Hint(HINT_CARD,1-tp,c73219648)
	local dc=Duel.TossDice(tp,1)
	if dc~=3 then return end
	if Duel.NegateEffect(ev) and rc:IsRelateToEffect(re) then
		Duel.Destroy(rc,REASON_EFFECT)
	end
end
function c73219648.atktg(e,c)
	return c:IsFaceup() and c:IsSetCard(SET_ARCHFIEND) and not c:IsCode(c73219648)
end