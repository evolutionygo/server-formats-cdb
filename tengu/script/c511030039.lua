--電幻機塊コンセントロール (Anime)
--Appliancer Socketroll (Anime)
--Scripted by pyrQ
function c511030039.initial_effect(c)
	--Special Summon from the hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511030039(c511030039,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,c:Alias())
	e1:SetCondition(c511030039.spcon)
	c:RegisterEffect(e1)
	--Special Summon from the Deck
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc511030039(c511030039,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,{c:Alias(),1})
	e2:SetCondition(c511030039.spcon2)
	e2:SetTarget(c511030039.sptg)
	e2:SetOperation(c511030039.spop)
	c:RegisterEffect(e2)
end
c511030039.listed_names={78447174}
function c511030039.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsCode,c:Alias()),tp,LOCATION_MZONE,0,1,nil)
end
function c511030039.filter(c,p)
	return c:IsCode(78447174) and c:IsFaceup() and c:IsControler(p)
end
function c511030039.spcon2(e,tp,eg,ep,ev,re,r,rp)
	return not eg:IsContains(e:GetHandler()) and eg:IsExists(c511030039.filter,1,nil,tp)
end
function c511030039.spfilter(c,e,tp)
	return c:IsCode(78447174) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP)
end
function c511030039.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511030039.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,LOCATION_DECK)
end
function c511030039.spop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511030039.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if #g>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end