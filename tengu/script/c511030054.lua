--家電機塊世界エレクトリリカル・ワールド (Anime)
--Appliancer Electrilyrical World (Anime)
--Scripted by pyrQ
function c511030054.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,c:Alias(),EFFECT_COUNT_CODE_OATH)
	e1:SetOperation(c511030054.activate)
	c:RegisterEffect(e1)
	--Return to hand
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1)
	e2:SetCondition(c511030054.thcon)
	e2:SetTarget(c511030054.thtg)
	e2:SetOperation(c511030054.thop)
	c:RegisterEffect(e2)
	--Move a monster
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCondition(c511030054.mvcon)
	e3:SetTarget(c511030054.mvtg)
	e3:SetOperation(c511030054.mvop)
	c:RegisterEffect(e3)
end
c511030054.listed_series={0x14a}
c511030054.listed_names={3875465}
function c511030054.thfilter(c)
	return c:IsSpell() and c:IsSetCard(0x14a) and c:IsAbleToHand() and not c:IsCode(3875465)
end
function c511030054.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(c511030054.thfilter,tp,LOCATION_DECK,0,nil)
	if #g>0 and Duel.SelectEffectYesNo(tp,e:GetHandler(),95) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end
function c511030054.confilter(c,tp)
	return c:IsSetCard(0x14a) and c:IsType(TYPE_LINK) and c:IsFaceup() and c:IsSummonType(SUMMON_TYPE_LINK) and c:IsControler(tp)
end
function c511030054.thcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511030054.confilter,1,nil,tp)
end
function c511030054.thfilter2(c)
	return c:IsSetCard(0x14a) and c:IsMonster() and c:IsAbleToHand()
end
function c511030054.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c511030054.thfilter2(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511030054.thfilter2,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c511030054.thfilter2,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,LOCATION_GRAVE)
end
function c511030054.thop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
function c511030054.mvcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==1-tp
end
function c511030054.mvfilter(c)
	return c:GetSequence()<5 and c:IsSetCard(0x14a) and c:IsType(TYPE_LINK) and c:IsLink(1)
end
function c511030054.mvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return c:IsLocation(LOCATION_MZONE) and c:IsControler(tp) and c511030054.mvfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511030054.mvfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringc511030054(37480144,0))
	Duel.SelectTarget(tp,c511030054.mvfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511030054.mvop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) or tc:IsControler(1-tp) or tc:IsImmuneToEffect(e) or Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOZONE)
	Duel.MoveSequence(tc,math.log(Duel.SelectDisableField(tp,1,LOCATION_MZONE,0,0),2))
end