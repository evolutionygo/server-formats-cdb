--幻獣機メガラプター
--Mecha Phantom Beast Megaraptor
function c31533704.initial_effect(c)
	--Gains the levels of all "Mecha Phantom Beast Token"
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_LEVEL)
	e1:SetValue(c31533704.lvval)
	c:RegisterEffect(e1)
	--Cannot be destroyed by battle or effects while you control a Token
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetCondition(c31533704.indcon)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e3)
	--Special Summon 1 "Mecha Phantom Beast Token"
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringc31533704(c31533704,0))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	e4:SetCountLimit(1,c31533704)
	e4:SetCondition(c31533704.spcon)
	e4:SetTarget(c31533704.sptg)
	e4:SetOperation(c31533704.spop)
	c:RegisterEffect(e4)
	--Search 1 "Mecha Phantom Beast" monster
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringc31533704(c31533704,1))
	e5:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCountLimit(1)
	e5:SetCost(c31533704.thcost)
	e5:SetTarget(c31533704.thtg)
	e5:SetOperation(c31533704.thop)
	c:RegisterEffect(e5)
end
c31533704.listed_series={SET_MECHA_PHANTOM_BEAST}
c31533704.listed_names={TOKEN_MECHA_PHANTOM_BEAST}
function c31533704.lvval(e,c)
	return Duel.GetMatchingGroup(aux.FaceupFilter(Card.IsCode,TOKEN_MECHA_PHANTOM_BEAST),c:GetControler(),LOCATION_MZONE,0,nil):GetSum(Card.GetLevel)
end
function c31533704.tknfilter(c)
	return c:IsType(TYPE_TOKEN) or c:IsOriginalType(TYPE_TOKEN)
end
function c31533704.indcon(e)
	return Duel.IsExistingMatchingCard(c31533704.tknfilter,e:GetHandlerPlayer(),LOCATION_ONFIELD,0,1,nil)
end
function c31533704.spfilter(c,tp)
	return c:IsControler(tp) and c:IsType(TYPE_TOKEN)
end
function c31533704.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c31533704.spfilter,1,nil,tp)
end
function c31533704.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,tp,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0)
end
function c31533704.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,TOKEN_MECHA_PHANTOM_BEAST,SET_MECHA_PHANTOM_BEAST,TYPES_TOKEN,0,0,3,RACE_MACHINE,ATTRIBUTE_WIND) then
		local token=Duel.CreateToken(tp,TOKEN_MECHA_PHANTOM_BEAST)
		Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c31533704.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroupCost(tp,Card.IsType,1,false,nil,nil,TYPE_TOKEN) end
	local g=Duel.SelectReleaseGroupCost(tp,Card.IsType,1,1,false,nil,nil,TYPE_TOKEN)
	Duel.Release(g,REASON_COST)
end
function c31533704.thfilter(c)
	return c:IsSetCard(SET_MECHA_PHANTOM_BEAST) and c:IsMonster() and c:IsAbleToHand()
end
function c31533704.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c31533704.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c31533704.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c31533704.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end