--E・HERO ネクロダークマン (Anime)
--Elemental HERO Necroshade (Anime)
function c511023014.initial_effect(c)
	--Normal Summon E・HERO without Tributing
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511023014(c511023014,0))
	e1:SetCategory(CATEGORY_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e1:SetCountLimit(1)
	e1:SetTarget(c511023014.target)
	e1:SetOperation(c511023014.operation)
	c:RegisterEffect(e1)
end
c511023014.listed_series={0x3008}
function c511023014.filter(c,ec)
	if not c:IsSetCard(0x3008) or not c:IsSummonableCard() then return false end
	local e1=Effect.CreateEffect(ec)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c511023014.ntcon)
	e1:SetReset(RESET_CHAIN)
	c:RegisterEffect(e1)
	local res=c:IsSummonable(true,nil)
	e1:Reset()
	return res
end
function c511023014.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511023014.filter,tp,LOCATION_HAND,0,1,nil,e:GetHandler()) end
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c511023014.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
	local tc=Duel.SelectMatchingCard(tp,c511023014.filter,tp,LOCATION_HAND,0,1,1,nil,c):GetFirst()
	if tc then
		local e1=Effect.CreateEffect(c)
		e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SUMMON_PROC)
		e1:SetCondition(c511023014.ntcon)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		Duel.Summon(tp,tc,true,nil)
	end
end
function c511023014.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and c:GetLevel()>4 and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end