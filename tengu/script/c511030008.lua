--ダイナレスラー・エスクリマメンチ (Anime)
--Dinowrestler Eskrimamenchi (Anime)
--scripted by pyrQ
local s,c511030008,alias=GetID()
function c511030008.initial_effect(c)
	alias = c:GetOriginalCodeRule()
	--Normal Summon without Tributing
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511030008(alias,0))
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c511030008.ntcon)
	c:RegisterEffect(e1)
	--Special Summon from the GY
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc511030008(alias,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCountLimit(1,alias)
	e2:SetCondition(c511030008.condition)
	e2:SetCost(c511030008.cost)
	e2:SetTarget(c511030008.target)
	e2:SetOperation(c511030008.operation)
	c:RegisterEffect(e2)
end
c511030008.listed_series={0x11a}
function c511030008.ntfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x11a)
end
function c511030008.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and c:GetLevel()>4 and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511030008.ntfilter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
function c511030008.condition(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and Duel.GetTurnPlayer()==tp
end
function c511030008.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToHandAsCost() end
	Duel.SendtoHand(e:GetHandler(),tp,REASON_COST)
end
function c511030008.filter(c,e,tp)
	return c:IsSetCard(0x11a) and c:IsLevelBelow(4) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511030008.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c511030008.filter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c511030008.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c511030008.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c511030008.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end