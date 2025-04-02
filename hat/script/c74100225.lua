--進化の特異点
--Evo-Singularity
function c74100225.initial_effect(c)
	--Special Summon 1 "Evolzaur" from the Extra Deck and attach 1 "Evoltile" and 1 "Evolsaur" to it
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc74100225(c74100225,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c74100225.target)
	e1:SetOperation(c74100225.activate)
	c:RegisterEffect(e1)
end
c74100225.listed_series={SET_EVOLTILE,SET_EVOLSAUR,SET_EVOLZAR}
function c74100225.filter(c,e)
	return c:IsMonster() and c:IsSetCard({SET_EVOLTILE,SET_EVOLSAUR}) and c:IsCanBeEffectTarget(e)
end
function c74100225.spfilter(c,e,tp)
	return c:IsSetCard(SET_EVOLZAR) and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c74100225.rescon(sg,e,tp,mg)
	return sg:IsExists(Card.IsSetCard,1,nil,SET_EVOLTILE) and sg:IsExists(Card.IsSetCard,1,nil,SET_EVOLSAUR)
end
function c74100225.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	local g=Duel.GetMatchingGroup(c74100225.filter,tp,LOCATION_GRAVE,0,nil,e)
	if chk==0 then return #g>=2 and aux.SelectUnselectGroup(g,e,tp,2,2,c74100225.rescon,0)
		and Duel.IsExistingMatchingCard(c74100225.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	local sg=aux.SelectUnselectGroup(g,e,tp,2,2,c74100225.rescon,1,tp,HINTMSG_ATTACH)
	Duel.SetTargetCard(sg)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,sg,#sg,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c74100225.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c74100225.spfilter,tp,LOCATION_EXTRA,0,nil,e,tp)
	if #g==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sc=g:Select(tp,1,1,nil):GetFirst()
	if sc and Duel.SpecialSummon(sc,0,tp,tp,false,false,POS_FACEUP)>0 then
		local mg=Duel.GetTargetCards(e)
		if #mg>0 then
		Duel.Overlay(sc,mg)
		end
	end
end