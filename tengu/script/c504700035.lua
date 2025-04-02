--百獣王 ベヒーモス
--Behemoth the King of All Animals (GOAT)
--Can be summoned with its procedure even if lv6
function c504700035.initial_effect(c)
	--summon/set with 1 tribute
	local e1=aux.AddNormalSummonProcedure(c,true,false,1,1,SUMMON_TYPE_TRIBUTE,aux.Stringc504700035(c504700035,0),nil,c504700035.otop)
	local e3=e1:Clone()
	e1:Reset()
	e3:SetCode(EFFECT_SUMMON_PROC)
	c:RegisterEffect(e3)
	local e2=aux.AddNormalSetProcedure(c,true,false,1,1,SUMMON_TYPE_TRIBUTE,aux.Stringc504700035(c504700035,0),nil,c504700035.otop)
	e3=e2:Clone()
	e2:Reset()
	e3:SetCode(EFFECT_SET_PROC)
	c:RegisterEffect(e3)
	--salvage
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringc504700035(c504700035,1))
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetCondition(c504700035.thcon)
	e3:SetTarget(c504700035.thtg)
	e3:SetOperation(c504700035.thop)
	c:RegisterEffect(e3)
end
function c504700035.otop(g,e,tp,eg,ep,ev,re,r,rp,c,minc,zone,relzone,exeff)
	--change base attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetReset(RESET_EVENT|RESETS_STANDARD_DISABLE&~RESET_TOFIELD)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetValue(2000)
	c:RegisterEffect(e1)
end
function c504700035.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_TRIBUTE)
end
function c504700035.filter(c)
	return c:IsRace(RACE_BEAST) and c:IsAbleToHand()
end
function c504700035.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c504700035.filter(chkc) end
	local ct=e:GetHandler():GetMaterialCount()
	if chk==0 then return ct>0 and Duel.IsExistingTarget(c504700035.filter,tp,LOCATION_GRAVE,0,ct,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c504700035.filter,tp,LOCATION_GRAVE,0,ct,ct,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,ct,0,0)
end
function c504700035.thop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	Duel.SendtoHand(sg,nil,REASON_EFFECT)
end