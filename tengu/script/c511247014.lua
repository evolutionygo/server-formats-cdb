--ＢＦ－天狗風のヒレン (Anime)
--Blackwing - Hillen the Tengu-wind (Anime)
function c511247014.initial_effect(c)
	--Special Summon this card and 1 Level 3 or lower "Blackwing" monster from your GY
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511247014(c511247014,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,c511247014,EFFECT_COUNT_CODE_DUEL)
	e1:SetCondition(function(e,tp) return Duel.GetAttacker():IsControler(1-tp) and Duel.GetAttackTarget()==nil end)
	e1:SetTarget(c511247014.sptg)
	e1:SetOperation(c511247014.spop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_BATTLE_DAMAGE)
	e2:SetCondition(function(e,tp,eg,ep,ev) return ep==tp and ev>=2000 end)
	c:RegisterEffect(e2)
end
c511247014.listed_series={SET_BLACKWING}
function c511247014.spfilter(c,e,tp)
	return c:IsLevelBelow(3) and c:IsSetCard(SET_BLACKWING) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511247014.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>=2
		and not Duel.IsPlayerAffectedByEffect(tp,CARD_BLUEEYES_SPIRIT)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.IsExistingMatchingCard(c511247014.spfilter,tp,LOCATION_GRAVE,0,1,c,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_GRAVE)
end
function c511247014.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,CARD_BLUEEYES_SPIRIT) or Duel.GetLocationCount(tp,LOCATION_MZONE)<2 then return end
	local c=e:GetHandler()
	if not (c:IsRelateToEffect(e) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511247014.spfilter,tp,LOCATION_GRAVE,0,1,1,c,e,tp)
	if #g==0 then return end
	g:AddCard(c)
	for sc in g:Iter() do
		if Duel.SpecialSummonStep(sc,0,tp,tp,false,false,POS_FACEUP) then
			--Their effects are negated
			sc:NegateEffects(c)
		end
	end
	Duel.SpecialSummonComplete()
end