--ギミック・パペット－ナイトメア
--Gimmick Puppet Nightmare
function c55204071.initial_effect(c)
	--Special Summon this card (from your hand) by Tributing 1 face-up Xyz Monster you control
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc55204071(c55204071,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,c55204071,EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c55204071.selfspcon)
	e1:SetTarget(c55204071.selfsptg)
	e1:SetOperation(c55204071.selfspop)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--Special Summon 1 "Gimmick Puppet Nightmare" from your hand or GY
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc55204071(c55204071,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(function(e) return e:GetHandler():IsSummonType(SUMMON_TYPE_SPECIAL+1) end)
	e2:SetTarget(c55204071.hgysptg)
	e2:SetOperation(c55204071.hgyspop)
	c:RegisterEffect(e2)
	--After this card is Special Summoned you cannot Special Summon monsters for the rest of this turn, except "Gimmick Puppet" monsters
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetOperation(c55204071.effop)
	c:RegisterEffect(e3)
end
c55204071.listed_series={SET_GIMMICK_PUPPET}
c55204071.listed_names={c55204071}
function c55204071.selfspcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.CheckReleaseGroup(tp,aux.FaceupFilter(Card.IsType,TYPE_XYZ),1,false,1,true,c,tp,nil,false,nil)
end
function c55204071.selfsptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.SelectReleaseGroup(tp,aux.FaceupFilter(Card.IsType,TYPE_XYZ),1,1,false,true,true,c,nil,nil,false,nil)
	if g then
		g:KeepAlive()
		e:SetLabelObject(g)
		return true
	end
	return false
end
function c55204071.selfspop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	if not g then return end
	Duel.Release(g,REASON_COST)
	g:DeleteGroup()
end
function c55204071.hgyspfilter(c,e,tp)
	return c:IsCode(c55204071) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c55204071.hgysptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c55204071.hgyspfilter,tp,LOCATION_HAND|LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND|LOCATION_GRAVE)
end
function c55204071.hgyspop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c55204071.hgyspfilter),tp,LOCATION_HAND|LOCATION_GRAVE,0,1,1,nil,e,tp)
	if #g>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c55204071.effop(e,tp,eg,ep,ev,re,r,rp)
	--Cannot Special Summon monsters, except "Gimmick Puppet" monsters
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringc55204071(c55204071,2))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CLIENT_HINT)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetTargetRange(1,0)
	e1:SetTarget(function(e,c) return not c:IsSetCard(SET_GIMMICK_PUPPET) end)
	e1:SetReset(RESET_PHASE|PHASE_END)
	Duel.RegisterEffect(e1,tp)
end