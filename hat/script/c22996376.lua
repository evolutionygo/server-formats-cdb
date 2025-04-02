--百獣王 ベヒーモス
--Behemoth the King of All Animals
function c22996376.initial_effect(c)
	--Normal Summon/Set with 1 Tribute
	local e1=aux.AddNormalSummonProcedure(c,true,true,1,1,SUMMON_TYPE_TRIBUTE,aux.Stringc22996376(c22996376,0),nil,c22996376.otop)
	local e2=aux.AddNormalSetProcedure(c,true,true,1,1,SUMMON_TYPE_TRIBUTE,aux.Stringc22996376(c22996376,0),nil,c22996376.otop)
	--Return Beast monsters from your GY to your hand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringc22996376(c22996376,1))
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetCondition(function(e) return e:GetHandler():IsTributeSummoned() end)
	e3:SetTarget(c22996376.thtg)
	e3:SetOperation(c22996376.thop)
	c:RegisterEffect(e3)
end
function c22996376.otop(g,e,tp,eg,ep,ev,re,r,rp,c,minc,zone,relzone,exeff)
	--Change original ATK
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(2000)
	e1:SetReset(RESET_EVENT|RESETS_STANDARD_DISABLE&~RESET_TOFIELD)
	c:RegisterEffect(e1)
end
function c22996376.thfilter(c)
	return c:IsRace(RACE_BEAST) and c:IsAbleToHand()
end
function c22996376.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c22996376.thfilter(chkc) end
	local ct=e:GetHandler():GetMaterialCount()
	if chk==0 then return ct>0 and Duel.IsExistingTarget(c22996376.thfilter,tp,LOCATION_GRAVE,0,ct,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c22996376.thfilter,tp,LOCATION_GRAVE,0,ct,ct,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,ct,0,0)
end
function c22996376.thop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetTargetCards(e):Match(Card.IsRace,nil,RACE_BEAST)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
	end
end