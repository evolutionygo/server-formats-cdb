--ウォーターリヴァイアサン＠イグニスター (Anime)
--Water Leviathan @Ignister (Anime)
--Scripted by Larry126
local s,c511600313,alias=GetID()
function c511600313.initial_effect(c)
	alias=c:GetOriginalCodeRule()
	c:EnableReviveLimit()
	--tohand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511600313(alias,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCondition(c511600313.thcon)
	e1:SetTarget(c511600313.thtg)
	e1:SetOperation(c511600313.thop)
	c:RegisterEffect(e1)
	--atk down
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc511600313(alias,1))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,alias)
	e2:SetTarget(c511600313.atktg)
	e2:SetOperation(c511600313.atkop)
	c:RegisterEffect(e2)
	--halve atk
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_SET_ATTACK)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetTarget(c511600313.target)
	e3:SetValue(c511600313.value)
	c:RegisterEffect(e3)
end
c511600313.listed_names={101011054}
function c511600313.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_RITUAL)
end
function c511600313.thfilter(c)
	return c:IsFaceup() and c:GetBaseAttack()<=2300 and c:IsAbleToHand()
end
function c511600313.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511600313.thfilter,tp,0,LOCATION_MZONE,1,nil) end
	local sg=Duel.GetMatchingGroup(c511600313.thfilter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,sg,#sg,0,0)
end
function c511600313.thop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c511600313.thfilter,tp,0,LOCATION_MZONE,nil)
	Duel.SendtoHand(sg,nil,REASON_EFFECT)
end
function c511600313.cfilter(c)
	return c:IsType(TYPE_LINK) and c:IsAbleToExtra()
end
function c511600313.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsFaceup() and chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil)
		and Duel.IsExistingMatchingCard(c511600313.cfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
	local g=Duel.GetMatchingGroup(c511600313.cfilter,tp,LOCATION_GRAVE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,#g,0,0)
end
function c511600313.atkop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511600313.cfilter,tp,LOCATION_GRAVE,0,nil)
	if Duel.SendtoDeck(g,nil,0,REASON_EFFECT)>0 then
		local tc=Duel.GetFirstTarget()
		if tc:IsFaceup() and tc:IsRelateToEffect(e) then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			e1:SetValue(-Duel.GetOperatedGroup():GetSum(Card.GetLink)*600)
			tc:RegisterEffect(e1)
		end
	end
end
function c511600313.target(e,c)
	return c==e:GetHandler():GetBattleTarget()
end
function c511600313.value(e,c)
	return c:GetAttack()/2
end