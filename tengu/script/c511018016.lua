--Amphibian Angel - Frog-Hael (anime)
function c511018016.initial_effect(c)
	--summon proc
	local e1=aux.AddNormalSummonProcedure(c,true,true,1,3,SUMMON_TYPE_TRIBUTE,aux.Stringc511018016(c511018016,0),c511018016.cfilter)
	--tribute check
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_MATERIAL_CHECK)
	e2:SetValue(c511018016.valcheck)
	c:RegisterEffect(e2)
	--cannot be attacked
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c511018016.cbacondition)
	e3:SetValue(aux.imval1)
	e3:SetLabelObject(e2)
	c:RegisterEffect(e3)
	--destroy all S/T
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringc511018016(c511018016,1))
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_SUMMON_SUCCESS)
	e4:SetCondition(c511018016.descon)
	e4:SetTarget(c511018016.destg)
	e4:SetOperation(c511018016.desop)
	e4:SetLabelObject(e2)
	c:RegisterEffect(e4)
	--special summon
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringc511018016(c511018016,2))
	e5:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e5:SetCode(EVENT_SUMMON_SUCCESS)
	e5:SetCondition(c511018016.spcon)
	e5:SetTarget(c511018016.sptg)
	e5:SetOperation(c511018016.spop)
	e5:SetLabelObject(e2)
	c:RegisterEffect(e5)
	--global thing
	aux.GlobalCheck(s,function()
		local ge1=Effect.GlobalEffect()
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SUMMON_SUCCESS)
		ge1:SetOperation(c511018016.chk)
		Duel.RegisterEffect(ge1,0)
		local ge2=ge1:Clone()
		ge2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
		Duel.RegisterEffect(ge2,0)
		local ge3=ge1:Clone()
		ge3:SetCode(EVENT_SPSUMMON_SUCCESS)
		Duel.RegisterEffect(ge3,0)
	end)
end
function c511018016.chk(e,tp,eg,ep,ev,re,r,rp)
	for tc in aux.Next(eg) do
		if tc:IsSetCard(0x12) then tc:RegisterFlagEffect(c511018016,0,0,0) end
	end
end
function c511018016.cfilter(c,tp)
	return c:IsSetCard(0x12) and (c:IsControler(tp) or c:IsFaceup())
end
function c511018016.valcheck(e,c)
	local g=c:GetMaterial()
	e:SetLabel(g:FilterCount(Card.IsSetCard,nil,0x12))
end
function c511018016.cbacondition(e,tp,eg,ep,ev,re,r,rp)
	local lo=e:GetLabelObject():GetLabel()
	return e:GetHandler():IsSummonType(SUMMON_TYPE_TRIBUTE) and lo>=1
end
function c511018016.descon(e,tp,eg,ep,ev,re,r,rp)
	local lo=e:GetLabelObject():GetLabel()
	return e:GetHandler():IsSummonType(SUMMON_TYPE_TRIBUTE) and lo>=2
end
function c511018016.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil,TYPE_SPELL+TYPE_TRAP)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,#g,0,0)
end
function c511018016.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil,TYPE_SPELL+TYPE_TRAP)
	Duel.Destroy(g,REASON_EFFECT)
end
function c511018016.spcon(e,tp,eg,ep,ev,re,r,rp)
	local lo=e:GetLabelObject():GetLabel()
	return e:GetHandler():IsSummonType(SUMMON_TYPE_TRIBUTE) and lo>=3
end
function c511018016.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c511018016.filter(c,e,tp)
	return c:IsSetCard(0x12) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:GetFlagEffect(c511018016)>0
end
function c511018016.spop(e,tp,eg,ep,ev,re,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local g=Duel.GetMatchingGroup(c511018016.filter,tp,LOCATION_GRAVE,0,nil,e,tp)
	if ft<=0 or #g<=0 then return end
	if Duel.IsPlayerAffectedByEffect(tp,CARD_BLUEEYES_SPIRIT) then ft=1 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=g:Select(tp,ft,ft,nil)
	Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
end