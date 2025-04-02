----スカイ・コア (Anime)
--Sky Core (Anime)
function c513000172.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c513000172.spcon)
	e1:SetTarget(c513000172.sptg)
	e1:SetOperation(c513000172.spop)
	c:RegisterEffect(e1)
end
c513000172.listed_names={31930787,100000057,100000058,100000059,100000060}
function c513000172.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_EFFECT) and c:IsPreviousLocation(LOCATION_MZONE)
end
function c513000172.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local sg=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,#sg,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,5,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE)
end
function c513000172.filter(c,e,tp)
	return c:IsCode(31930787,100000057,100000058,100000059,100000060) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c513000172.rescon(sg,e,tp,mg)
	return sg:IsExists(Card.IsCode,1,nil,31930787) and sg:IsExists(Card.IsCode,1,nil,100000057) and sg:IsExists(Card.IsCode,1,nil,100000058) and sg:IsExists(Card.IsCode,1,nil,100000059) and sg:IsExists(Card.IsCode,1,nil,100000060)
end
function c513000172.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local sg=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,0,nil)
	Duel.Destroy(sg,REASON_EFFECT)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 or (ft>1 and Duel.IsPlayerAffectedByEffect(tp,CARD_BLUEEYES_SPIRIT)) then return end
 	local sg=Duel.GetMatchingGroup(c513000172.filter,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_GRAVE,0,nil,e,tp)
 	if not c513000172.rescon(sg) then return end
 	local spg=aux.SelectUnselectGroup(sg,e,tp,5,5,c513000172.rescon,1,tp,HINTMSG_SPSUMMON)
	if #sg>0 then
		Duel.SpecialSummon(spg,0,tp,tp,false,false,POS_FACEUP)
	end
end