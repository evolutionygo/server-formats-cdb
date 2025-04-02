--ヴァイロン・ポリトープ
--Vylon Polytope
function c65659181.initial_effect(c)
	--Special Summon any number of "Vylon" Monster Cards you control that are Equip Cards
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc65659181(c65659181,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_MAIN_END|TIMINGS_CHECK_MONSTER_E)
	e1:SetTarget(c65659181.sptg)
	e1:SetOperation(c65659181.spop)
	c:RegisterEffect(e1)
end
c65659181.listed_series={SET_VYLON}
function c65659181.spfilter(c,e,tp)
	return c:IsSetCard(SET_VYLON) and c:IsMonsterCard() and c:IsEquipCard() and c:IsFaceup()
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
end
function c65659181.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and chkc:IsControler(tp) and c65659181.spfilter(chkc,e,tp) end
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if chk==0 then return ft>0 and Duel.IsExistingTarget(c65659181.spfilter,tp,LOCATION_SZONE,0,1,nil,e,tp) end
	if Duel.IsPlayerAffectedByEffect(tp,CARD_BLUEEYES_SPIRIT) then ft=1 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c65659181.spfilter,tp,LOCATION_SZONE,0,1,ft,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,#g,tp,0)
end
function c65659181.spop(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetTargetCards(e):Filter(Card.IsCanBeSpecialSummoned,nil,e,0,tp,false,false,POS_FACEUP_DEFENSE)
	if #tg==0 or (#tg>1 and Duel.IsPlayerAffectedByEffect(tp,CARD_BLUEEYES_SPIRIT)) then return end
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local exg=nil
	if #tg>ft then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=tg:Select(tp,ft,ft,nil)
		tg,exg=tg:Split(function(c) return sg:IsContains(c) end,nil)
	end
	local c=e:GetHandler()
	for tc in tg:Iter() do
		if Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP_DEFENSE) then
			--Banish it when it leaves the field
			local e1=Effect.CreateEffect(c)
			e1:SetDescription(3300)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
			e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
			e1:SetValue(LOCATION_REMOVED)
			e1:SetReset(RESET_EVENT|RESETS_REDIRECT)
			tc:RegisterEffect(e1,true)
		end
	end
	Duel.SpecialSummonComplete()
	if exg then
		Duel.SendtoGrave(exg,REASON_RULE,PLAYER_NONE,PLAYER_NONE)
	end
end