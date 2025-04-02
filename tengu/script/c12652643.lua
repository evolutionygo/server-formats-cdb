--古代の機械究極巨人
--Ultimate Ancient Gear Golem
function c12652643.initial_effect(c)
	c:EnableReviveLimit()
	--Fusion Materials: "Ancient Gear Golem" + 2 "Ancient Gear" monsters
	aux.AddFusionProcCode2N(c,true,true,CARD_ANCIENT_GEAR_GOLEM,1,aux.FilterBoolFunctionEx(Card.IsSetCard,SET_ANCIENT_GEAR),2)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.fuslimit)
	c:RegisterEffect(e1)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e2)
	--If this card attacks, your opponent cannot activate Spell/Trap Cards until the end of the Damage Step
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCode(EFFECT_CANNOT_ACTIVATE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,1)
	e3:SetValue(c12652643.aclimit)
	e3:SetCondition(c12652643.actcon)
	c:RegisterEffect(e3)
	--Special Summon 1 "Ancient Gear Golem" from your GY
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringc12652643(c12652643,0))
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e4:SetCode(EVENT_DESTROYED)
	e4:SetTarget(c12652643.sptg)
	e4:SetOperation(c12652643.spop)
	c:RegisterEffect(e4)
end
c12652643.listed_series={SET_ANCIENT_GEAR}
c12652643.listed_names={CARD_ANCIENT_GEAR_GOLEM}
c12652643.material_setcode=SET_ANCIENT_GEAR
function c12652643.aclimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c12652643.actcon(e)
	return Duel.GetAttacker()==e:GetHandler()
end
function c12652643.spfilter(c,e,tp)
	return c:IsCode(CARD_ANCIENT_GEAR_GOLEM) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c12652643.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c12652643.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c12652643.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c12652643.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,tp,0)
end
function c12652643.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)
	end
end