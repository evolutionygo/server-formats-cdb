--ラインモンスター Ｋホース
--Line Monster K Horse
--scripted by Shad3
function c511005006.initial_effect(c)
	--Normal/Special Summon effect
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c511005006.destg)
	e1:SetOperation(c511005006.desop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e4=e1:Clone()
	e4:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e4)
	--Special Summon lv3
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetCondition(c511005006.spcon)
	e3:SetTarget(c511005006.sptg)
	e3:SetOperation(c511005006.spop)
	c:RegisterEffect(e3)
end
c511005006.listed_names={41493640}
function c511005006.desfilter(c,e)
	local seq=e:GetHandler():GetSequence()
	local sseq=c:GetSequence()
	return sseq<5 and ((seq==0 and sseq==3) or (seq==1 and (sseq==4 or sseq==2)) or (seq==2 and (sseq==3 or sseq==1)) or (seq==3 and (sseq==0 or sseq==2)) 
	or (seq==4 and sseq==1))
end
function c511005006.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_SZONE):Filter(c511005006.desfilter,nil,e)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c511005006.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_SZONE):Filter(c511005006.desfilter,nil,e)
	if #g==0 then return end
	local tc=nil
	if #g==1 then
		tc=g:GetFirst()
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		tc=g:Select(tp,1,1,nil)
	end
	Duel.HintSelection(tc)
	Duel.Destroy(tc,REASON_EFFECT)
end
function c511005006.spcon(e,tp,eg,ep,ev,re,r,rp)
	return re and re:GetOwner()==e:GetHandler() and eg:IsExists(aux.FilterBoolFunction(Card.IsTrap),1,nil)
end
function c511005006.spfilter(c,e,tp)
	return c:GetLevel()==3 and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and not c:IsCode(41493640)
end
function c511005006.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511005006.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c511005006.spop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tg=Duel.SelectMatchingCard(tp,c511005006.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if #tg>0 then
		Duel.SpecialSummon(tg,0,tp,tp,false,false,POS_FACEUP)
	end
end